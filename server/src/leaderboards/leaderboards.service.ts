import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { Leaderboard } from './leaderboard.model';

@Injectable()
export class LeaderboardsService {
  constructor(
    @InjectModel('Leaderboard') private readonly leaderboardModel: Model<Leaderboard>,
  ) {}

  async insertLeaderboard(gameId: string,userId: string,point: number) {
    const newLeaderboard = new this.leaderboardModel({
      gameId,
      userId,
      point
    });
    const result = await newLeaderboard.save();
    return result.id as string;
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
    leaderboardId: string,
    point: number
  ) {
    const updatedLeaderboard = await this.findLeaderboard(leaderboardId);
    if (point) {
      updatedLeaderboard.point = point;
    }
    updatedLeaderboard.save();
  }

  async deleteLeaderboard(Id: string) {
    const result = await this.leaderboardModel.deleteOne({_id: Id}).exec();
    if (result.deletedCount === 0) {
      throw new NotFoundException('Could not find leaderboard.');
    }
  }

  private async findLeaderboard(id: string): Promise<Leaderboard> {
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