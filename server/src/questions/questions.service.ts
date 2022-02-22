import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { QuestionDocument } from './question.model';

@Injectable()
export class QuestionsService {
  constructor(
    @InjectModel('Question') private readonly questionModel: Model<QuestionDocument>,
  ) {}

  async insertQuestion(
    gameId: string,
    questionText: string,
    questionPhoto: string,
    questionPoint: number,
    timeLimit: number,
    isMultiSelect: boolean,
    type: number) {
    const newQuestion = new this.questionModel({
      gameId,
      questionText,
      questionPhoto,
      questionPoint,
      timeLimit,
      isMultiSelect,
      type
    });
    
    const result = await newQuestion.save();
    return result.id as string;
  }

  async getQuestions() {
    const questions = await this.questionModel.find().exec();
    return questions.map(question => ({
      id: question.id,
      gameId: question.gameId,
      questionText: question.questionText,
      questionPhoto: question.questionPhoto,
      questionPoint: question.questionPoint,
      isMultiSelect: question.isMultiSelect,
      type: question.type,
    }));
  }

  async getSingleQuestion(questionId: string) {
    const question = await this.findQuestion(questionId);
    return {
      id: question.id,
      gameId: question.gameId,
      questionText: question.questionText,
      questionPhoto: question.questionPhoto,
      questionPoint: question.questionPoint,
      timeLimit: question.timeLimit,
      isMultiSelect: question.isMultiSelect,
      type: question.type,
    };
  }

  async updateQuestion(
    questionId: string,
    questionText: string,
    questionPhoto: string,
    questionPoint: number,
    timeLimit: number,
    isMultiSelect: boolean,
    type: number
  ) {
    const updatedQuestion = await this.findQuestion(questionId);
    if (questionText) {
      updatedQuestion.questionText = questionText;
    }
    if (questionPhoto) {
      updatedQuestion.questionPhoto = questionPhoto;
    } 
    if (questionPoint) {
      updatedQuestion.questionPoint = questionPoint;
    }
    if (timeLimit) {
      updatedQuestion.timeLimit = timeLimit;
    }
    if (isMultiSelect) {
      updatedQuestion.isMultiSelect = isMultiSelect;
    }
    if (type) {
      updatedQuestion.type = type;
    }
    updatedQuestion.save();
  }

  async deleteQuestion(Id: string) {
    const result = await this.questionModel.deleteOne({_id: Id}).exec();
    if (result.deletedCount === 0) {
      throw new NotFoundException('Could not find question.');
    }
  }

  private async findQuestion(id: string): Promise<QuestionDocument> {
    let question;
    try {
      question = await this.questionModel.findById(id).exec();
    } catch (error) {
      throw new NotFoundException('Could not find question.');
    }
    if (!question) {
      throw new NotFoundException('Could not find question.');
    }
    return question;
  }
}