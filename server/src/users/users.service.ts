import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Game } from 'src/games/game.model';

import { User, UserDocument } from './user.model';

@Injectable()
export class UsersService {
  constructor(
    @InjectModel('User') private readonly userModel: Model<User>) {}

  async insertUser(
    nickname: string, 
    playingGameId: string, 
    isHost: boolean
  ) {
    const newUser = new this.userModel({
      nickname,
      playingGameId,
      isHost,
    });
    const result = await newUser.save();
    return result;
  }

  async getUsers() {
    const users = await this.userModel.find().exec();
    return users.map(user => ({
      id: user.id,
      nickname: user.nickname,
      playingGameId: user.playingGameId,
      isHost: user.isHost,
    }));
  }


  async getUsersInGame(gameId: string) {
    const users = await this.userModel.find({playingGameId:gameId,isHost:false}).sort({point:-1}).exec();
    return users;
  }

  async getSingleUser(userId: string) {
    const user = await this.findUser(userId);
    return {
      id: user.id,
      nickname: user.nickname,
      playingGameId: user.playingGameId,
      isHost: user.isHost,
    };
  }

  async updateUser(
    userId: string,
    nickname: string,
    isHost: boolean,
  ) {
    const updatedUser = await this.findUser(userId);
    if (nickname) {
      updatedUser.nickname = nickname;
    }
    if (isHost) {
      updatedUser.isHost = isHost;
    }
    updatedUser.save();
  }

  async deleteUser(id: string) {
    const result = await this.userModel.deleteOne({_id: id}).exec();
    if (result.deletedCount === 0) {
      throw new NotFoundException('Could not find user.');
    }
  }

  private async findUser(id: string): Promise<UserDocument> {
    let user;
    try {
      user = await this.userModel.findById(id).exec();
    } catch (error) {
      throw new NotFoundException('Could not find user.');
    }
    if (!user) {
      throw new NotFoundException('Could not find user.');
    }
    return user;
  }
}