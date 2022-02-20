import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Patch,
    Delete,
  } from '@nestjs/common';
  
  import { UsersService } from './users.service';
  
  @Controller('users')
  export class UsersController {
    constructor(private readonly usersService: UsersService) {}
  
    @Post()
    async addUser(
      @Body('nickname') nickname: string,
      @Body('playingGameId') playingGameId: string,
      @Body('isHost') isHost: boolean,
    ) {
      const generatedId = await this.usersService.insertUser(
        nickname,
        playingGameId,
        isHost,
      );
      return { id: generatedId };
    }
  
    @Get()
    async getAllUsers() {
      const users = await this.usersService.getUsers();
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
      await this.usersService.updateUser(id, nickname, playingGameId, isHost);
      return null;
    }
  
    @Delete(':id')
    async removeUser(@Param('id') id: string) {
        await this.usersService.deleteUser(id);
        return null;
    }
  }