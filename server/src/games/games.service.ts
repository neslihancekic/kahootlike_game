import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import * as math from 'math';

import { GameDocument, GameState} from './game.model';
import { QuestionDocument } from 'src/questions/question.model';
import { ChoiceDocument } from 'src/choices/choices.model';

@Injectable()
export class GamesService {
  constructor(
    @InjectModel('Game') private readonly gameModel: Model<GameDocument>,
    @InjectModel('Question') private readonly questionModel: Model<QuestionDocument>,
    @InjectModel('Choice') private readonly choiceModel: Model<ChoiceDocument>
    ) {}

  async insertGame(title: string, desc: string) {
    const newGame = new this.gameModel({
      title,
      description: desc,
    });
    var pin=math.floor(10000000 + Math.random() * 90000000);
    var gameWithSamePin = await this.gameModel.findOne({pin:pin}).exec();
    while(gameWithSamePin!=null){
      pin=math.floor(10000000 + Math.random() * 90000000);
      gameWithSamePin = await this.gameModel.findOne({pin:pin}).exec();
    }
    newGame.pin = pin;
    const result = await newGame.save();
    return result.id as string;
  }

  async getGames() {
    const games = await this.gameModel.find().exec();
    return games.map(game => ({
      id: game.id,
      title: game.title,
      description: game.description,
      pin: game.pin,
      state: game.state,
    }));
  }

  async getSingleGame(gameId: string) {
    const game = await this.findGame(gameId);
    return game;
  }

  async startGame(gameId: string) {
    const game = await this.findGame(gameId);
    game.state=GameState.InProgress;
    game.save();
    return game;
  }
  async getSingleGameState(gameId: string) {
    const game = await this.findGame(gameId);
    return game.state;
  }

  async updateGame(
    gameId: string,
    title: string,
    desc: string,
    state: number,
    pin: number
  ) {
    const updatedGame = await this.findGame(gameId);
    if (title) {
      updatedGame.title = title;
    }
    if (desc) {
      updatedGame.description = desc;
    }
    if (state) {
      updatedGame.state = state;
      if(state==GameState.Done){
        updatedGame.pin=null
      }
    }
    if (pin) {
      updatedGame.pin = pin;
    }
    updatedGame.save();
  }

  async deleteGame(id: string) {

    const questions = await this.questionModel.find({gameId: id}).exec();
    var x =questions.map(obj => obj['_id']);
    await this.choiceModel.deleteMany({questionId: { $in: x}}).exec();
    await this.questionModel.deleteMany({gameId: id}).exec();
    const result = await this.gameModel.deleteOne({_id: id}).exec();
    if (result.deletedCount === 0) {
      throw new NotFoundException('Could not find game.');
    }
  }

  async findGameByPin(pin: string): Promise<GameDocument> {
    let game;
    try {
      game = await this.gameModel.findOne({pin:pin}).populate({
        path: 'questions',populate:{path: 'choices'}
      }).exec();
      console.log(game)
    } catch (error) {
      throw new NotFoundException('Could not find game.');
    }
    if (!game) {
      throw new NotFoundException('Could not find game.');
    }
    return game;
  }

  private async findGame(id: string): Promise<GameDocument> {
    let game;
    try {
      game = await this.gameModel.findById(id).populate({
        path: 'questions',populate:{path: 'choices'}
      }).exec();
      console.log(game)
    } catch (error) {
      throw new NotFoundException('Could not find game.');
    }
    if (!game) {
      throw new NotFoundException('Could not find game.');
    }
    return game;
  }


}