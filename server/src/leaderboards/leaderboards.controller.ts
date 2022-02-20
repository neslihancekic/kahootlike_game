import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Patch,
    Delete,
  } from '@nestjs/common';
  
  import { LeaderboardsService } from './leaderboards.service';
  
  @Controller('leaderboards')
  export class LeaderboardsController {
    constructor(private readonly leaderboardsService: LeaderboardsService) {}
  
    @Post()
    async addLeaderboard(
      @Body('gameId') gameId: string,
      @Body('userId') userId: string,
      @Body('point') point: number,
    ) {
      const generatedId = await this.leaderboardsService.insertLeaderboard(
        gameId,
        userId,
        point,
      );
      return { id: generatedId };
    }
  
    @Get()
    async getAllLeaderboards() {
      const leaderboards = await this.leaderboardsService.getLeaderboards();
      return leaderboards;
    }
  
    @Get(':id')
    getLeaderboard(@Param('id') Id: string) {
      return this.leaderboardsService.getSingleLeaderboard(Id);
    }
  
    @Patch(':id')
    async updateLeaderboard(
      @Param('id') id: string,
      @Body('point') point: number,
    ) {
      await this.leaderboardsService.updateLeaderboard(id,point);
      return null;
    }
  
    @Delete(':id')
    async removeLeaderboard(@Param('id') Id: string) {
        await this.leaderboardsService.deleteLeaderboard(Id);
        return null;
    }
  }