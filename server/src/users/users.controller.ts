import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Patch,
    Delete,
  } from '@nestjs/common';
import { GamesService } from 'src/games/games.service';
  
  import { UsersService } from './users.service';
  
  @Controller('users')
  export class UsersController {
    constructor(private readonly usersService: UsersService,private readonly gamesService: GamesService) {}
  
    @Post()
    async addUser(
      @Body('nickname') nickname: string,
      @Body('pin') pin: string,
      @Body('isHost') isHost: boolean,
    ) {
      const game = await this.gamesService.findGameByPin(pin);
      const generatedUser = await this.usersService.insertUser(
        nickname,
        game.id,
        isHost,
      );
      return generatedUser;
    }
  
    @Get()
    async getAllUsers() {
      const users = await this.usersService.getUsers();
      return users;
    }

    @Get('/inGame/:gameId')
    async getUsersInGame(@Param('gameId') gameId: string) {
      const users = await this.usersService.getUsersInGame(gameId);
      return users;
    }
  
    @Get(':id')
    getUser(@Param('id') userId: string) {
      return this.usersService.getSingleUser(userId);
    }
  
    @Patch(':id')
    async updateUser(
      @Param('id') id: string,
      @Body('nickname') nickname: string,
      @Body('playingGameId') playingGameId: string,
      @Body('isHost') isHost: boolean,
    ) {
      await this.usersService.updateUser(id, nickname, isHost);
      return null;
    }
  
    @Delete(':id')
    async removeUser(@Param('id') id: string) {
        await this.usersService.deleteUser(id);
        return null;
    }
  }