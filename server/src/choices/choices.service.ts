import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { Choice } from './choices.model';

@Injectable()
export class ChoicesService {
  constructor(
    @InjectModel('Choice') private readonly choiceModel: Model<Choice>,
  ) {}

  async insertChoice(
    questionId: string,
    choiceText: string,
    isCorrectAnswer: boolean,
    order: number) {
    const newChoice = new this.choiceModel({
      questionId,choiceText,isCorrectAnswer,order
    });
    const result = await newChoice.save();
    return result.id as string;
  }

  async getChoices() {
    const choices = await this.choiceModel.find().exec();
    return choices.map(choice => ({
      id: choice.id,
      questionId: choice.questionId,
      choiceText: choice.choiceText,
      isCorrectAnswer: choice.isCorrectAnswer,
      order: choice.order
    }));
  }

  async getSingleChoice(choiceId: string) {
    const choice = await this.findChoice(choiceId);
    return {
      id: choice.id,
      questionId: choice.questionId,
      choiceText: choice.choiceText,
      isCorrectAnswer: choice.isCorrectAnswer,
      order: choice.order
    };
  }

  async updateChoice(
    choiceId: string,
    choiceText: string,
    isCorrectAnswer: boolean,
    order: number
  ) {
    const updatedChoice = await this.findChoice(choiceId);
    if (choiceText) {
      updatedChoice.choiceText = choiceText;
    }
    if (isCorrectAnswer) {
      updatedChoice.isCorrectAnswer = isCorrectAnswer;
    }
    if (order) {
      updatedChoice.order = order;
    }
    updatedChoice.save();
  }

  async deleteChoice(Id: string) {
    const result = await this.choiceModel.deleteOne({_id: Id}).exec();
    if (result.deletedCount === 0) {
      throw new NotFoundException('Could not find choice.');
    }
  }

  private async findChoice(id: string): Promise<Choice> {
    let choice;
    try {
      choice = await this.choiceModel.findById(id).exec();
    } catch (error) {
      throw new NotFoundException('Could not find choice.');
    }
    if (!choice) {
      throw new NotFoundException('Could not find choice.');
    }
    return choice;
  }
}