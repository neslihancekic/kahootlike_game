import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Patch,
    Delete,
  } from '@nestjs/common';
  
  import { GamesService } from './games.service';
  
  @Controller('games')
  export class GamesController {
    constructor(private readonly gamesService: GamesService) {}
  
    @Post()
    async addGame(
      @Body('title') Title: string,
      @Body('description') Desc: string
    ) {
      const generatedId = await this.gamesService.insertGame(
        Title,
        Desc
      );
      return { id: generatedId };
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