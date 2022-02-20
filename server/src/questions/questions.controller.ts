import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Patch,
    Delete,
  } from '@nestjs/common';
  
  import { QuestionsService } from './questions.service';
  
  @Controller('questions')
  export class QuestionsController {
    constructor(private readonly questionsService: QuestionsService) {}
  
    @Post()
    async addQuestion(
      @Body('gameId') gameId: string,
      @Body('questionText') questionText: string,
      @Body('questionPhoto') questionPhoto: string,
      @Body('questionPoint') questionPoint: number,
      @Body('timeLimit') timeLimit: number,
      @Body('isMultiSelect') isMultiSelect: boolean,
      @Body('type') type: number,
    ) {
      const generatedId = await this.questionsService.insertQuestion(
        gameId,
        questionText,
        questionPhoto,
        questionPoint,
        timeLimit,
        isMultiSelect,
        type
      );
      return { id: generatedId };
    }
  
    @Get()
    async getAllQuestions() {
      const questions = await this.questionsService.getQuestions();
      return questions;
    }
  
    @Get(':id')
    getQuestion(@Param('id') Id: string) {
      return this.questionsService.getSingleQuestion(Id);
    }
  
    @Patch(':id')
    async updateQuestion(
      @Param('id') id: string,
      @Body('questionText') questionText: string,
      @Body('questionPhoto') questionPhoto: string,
      @Body('questionPoint') questionPoint: number,
      @Body('timeLimit') timeLimit: number,
      @Body('isMultiSelect') isMultiSelect: boolean,
      @Body('type') type: number,
    ) {
      await this.questionsService.updateQuestion(id,questionText,questionPhoto,questionPoint,timeLimit,isMultiSelect,type);
      return null;
    }
  
    @Delete(':id')
    async removeQuestion(@Param('id') Id: string) {
        await this.questionsService.deleteQuestion(Id);
        return null;
    }
  }