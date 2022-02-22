import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Patch,
    Delete,
  } from '@nestjs/common';
import { ChoicesService } from 'src/choices/choices.service';
import { Question } from 'src/questions/question.model';
import { QuestionsService } from 'src/questions/questions.service';
  
  import { GamesService } from './games.service';
  
  @Controller('games')
  export class GamesController {
    constructor(
      private readonly gamesService: GamesService,
      private readonly questionsService: QuestionsService,
      private readonly choicesService: ChoicesService) { }

    @Post()
    async addGame(
      @Body('title') Title: string,
      @Body('description') Desc: string,
      @Body('questions') questions: Array<Question>
    ) {
      const generatedId = await this.gamesService.insertGame(
        Title,
        Desc
      );
      for (var question of questions) {
          var questionId = await this.questionsService.insertQuestion(
          generatedId,
          question.questionText,
          question.questionPhoto,
          question.questionPoint,
          question.timeLimit,
          question.isMultiSelect,
          question.type);
          for (var choice of question.choices) {
            const choiceId = await this.choicesService.insertChoice(
              questionId,
              choice.choiceText,
              choice.isCorrectAnswer,
              choice.order);
          }
      }
      return this.gamesService.getSingleGame(generatedId);;
    }
  
    @Get()
    async getAllGames() {
      const games = await this.gamesService.getGames();
      return games;
    }
  
    @Get(':id')
    getGame(@Param('id') id: string) {
      return this.gamesService.getSingleGame(id);
    }

    @Patch('/start/:id')
    startGame(@Param('id') id: string) {
      return this.gamesService.startGame(id);
    }

    @Get('/state/:id')
    getGameState(@Param('id') id: string) {
      return this.gamesService.getSingleGameState(id);
    }

    @Get('pin/:pin')
    getGameByPin(@Param('pin') pin: string) {
      return this.gamesService.findGameByPin(pin);
    }
  
    @Patch(':id')
    async updateGame(
      @Param('id') id: string,
      @Body('title') title: string,
      @Body('description') desc: string,
      @Body('state') state: number,
      @Body('pin') pin: number
    ) {
      await this.gamesService.updateGame(id, title,desc,state,pin);
      return null;
    }
  
    @Delete(':id')
    async removeGame(@Param('id') Id: string) {
        await this.gamesService.deleteGame(Id);
        return null;
    }
  }