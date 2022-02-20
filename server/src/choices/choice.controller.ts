import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Patch,
    Delete,
  } from '@nestjs/common';
  
  import { ChoicesService } from './choices.service';
  
  @Controller('choices')
  export class ChoicesController {
    constructor(private readonly choicesService: ChoicesService) {}
  
    @Post()
    async addChoice(
      @Body('questionId') questionId: string,
      @Body('choiceText') choiceText: string,
      @Body('isCorrectAnswer') isCorrectAnswer: boolean,
      @Body('order') order: number,
    ) {
      const generatedId = await this.choicesService.insertChoice(
        questionId,
        choiceText,
        isCorrectAnswer,
        order
      );
      return { id: generatedId };
    }
  
    @Get()
    async getAllChoices() {
      const choices = await this.choicesService.getChoices();
      return choices;
    }
  
    @Get(':id')
    getChoice(@Param('id') Id: string) {
      return this.choicesService.getSingleChoice(Id);
    }
  
    @Patch(':id')
    async updateChoice(
      @Param('id') id: string,
      @Body('choiceText') choiceText: string,
      @Body('isCorrectAnswer') isCorrectAnswer: boolean,
      @Body('order') order: number,
    ) {
      await this.choicesService.updateChoice(id, choiceText, isCorrectAnswer, order);
      return null;
    }
  
    @Delete(':id')
    async removeChoice(@Param('id') Id: string) {
        await this.choicesService.deleteChoice(Id);
        return null;
    }
  }