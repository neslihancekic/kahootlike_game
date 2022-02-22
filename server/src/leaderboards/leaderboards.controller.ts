import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Patch,
    Delete,
  } from '@nestjs/common';
import { UsersService } from 'src/users/users.service';
  
  import { LeaderboardsService } from './leaderboards.service';
  
  @Controller('leaderboards')
  export class LeaderboardsController {
    constructor(private readonly leaderboardsService: LeaderboardsService,
                private readonly usersService: UsersService) {}
  
    @Post()
    async addLeaderboard(
      @Body('gameId') gameId: string
    ) {
      const generatedIds = await this.leaderboardsService.insertLeaderboard(
        gameId
      );
      return  generatedIds ;
    }
  
    @Get()
    async getAllLeaderboards() {
      const leaderboards = await this.leaderboardsService.getLeaderboards();
      return leaderboards;
    }
  
    @Get(':gameId')
    getLeaderboard(@Param('gameId') gameId: string) {
      return this.leaderboardsService.getAllLeaderboard(gameId);
    }
  
    @Patch(':gameId/:userId')
    async updateLeaderboard(
      @Param('gameId') gameId: string,
      @Param('userId') userId: string,
      @Body('point') point: number,
    ) {
      await this.leaderboardsService.updateLeaderboard(gameId,userId,point);
      return null;
    }
  
    @Delete(':id')
    async removeLeaderboard(@Param('id') Id: string) {
        await this.leaderboardsService.deleteLeaderboard(Id);
        return null;
    }
  }