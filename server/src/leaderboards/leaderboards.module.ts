import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { LeaderboardsController } from './leaderboards.controller';
import { LeaderboardsService } from './leaderboards.service';
import { LeaderboardSchema } from './leaderboard.model';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: 'Leaderboard', schema: LeaderboardSchema }]),
  ],
  controllers: [LeaderboardsController],
  providers: [LeaderboardsService],
})
export class LeaderboardsModule {}