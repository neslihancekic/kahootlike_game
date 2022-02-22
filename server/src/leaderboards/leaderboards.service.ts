import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { GameDocument } from 'src/games/game.model';
import { User, UserDocument } from 'src/users/user.model';

import { LeaderBoardDocument } from './leaderboard.model';

@Injectable()
export class LeaderboardsService {
  constructor(
    @InjectModel('Leaderboard') private readonly leaderboardModel: Model<LeaderBoardDocument>,
    @InjectModel('User') private readonly userModel: Model<UserDocument>,) {}

  async insertLeaderboard(gameId: string) {
    const users = await this.userModel.find({playingGameId:gameId,isHost:false}).exec();
    for(var u of users){
      const newLeaderboard = new this.leaderboardModel({
        gameId,userId:u.id
      });
      const result = await newLeaderboard.save();
    }
    return "Leaderboard created!" as string;
  }

  async getLeaderboards() {
    const leaderboards = await this.leaderboardModel.find().exec();
    return leaderboards.map( leaderboard=> ({
      id: leaderboard.id,
      gameId: leaderboard.gameId,
      userId: leaderboard.userId,
      point: leaderboard.point,
    }));
  }
  async getAllLeaderboard(gameId: string) {
    const leaderboards = await this.leaderboardModel.find({gameId:gameId}).populate({
      path: 'user'}).exec();
    return leaderboards
  }

  async getSingleLeaderboard(leaderboardId: string) {
    const leaderboard = await this.findLeaderboard(leaderboardId);
    return {
      id: leaderboard.id,
      gameId: leaderboard.gameId,
      userId: leaderboard.userId,
      point: leaderboard.point,
    };
  }

  async updateLeaderboard(
    gameId: string,
    userId: string,
    point: number,
  ) {
    const updatedLeaderboard =  await this.leaderboardModel.findOne({gameId:gameId,userId:userId}).exec();
    if (point) {
      updatedLeaderboard.point = point;
    }
    updatedLeaderboard.isFinished=true;
    updatedLeaderboard.save();
  }

  async deleteLeaderboard(Id: string) {
    const result = await this.leaderboardModel.deleteOne({_id: Id}).exec();
    if (result.deletedCount === 0) {
      throw new NotFoundException('Could not find leaderboard.');
    }
  }

  private async findLeaderboard(id: string): Promise<LeaderBoardDocument> {
    let leaderboard;
    try {
      leaderboard = await this.leaderboardModel.findById(id).exec();
    } catch (error) {
      throw new NotFoundException('Could not find leaderboard.');
    }
    if (!leaderboard) {
      throw new NotFoundException('Could not find leaderboard.');
    }
    return leaderboard;
  }
}