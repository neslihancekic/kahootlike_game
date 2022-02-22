import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { LeaderboardsController } from './leaderboards.controller';
import { LeaderboardsService } from './leaderboards.service';
import { LeaderBoardSchema } from './leaderboard.model';
import { UsersController } from 'src/users/users.controller';
import { UsersService } from 'src/users/users.service';
import { UserSchema } from 'src/users/user.model';
import { GameSchema } from 'src/games/game.model';
import { GamesController } from 'src/games/games.controller';
import { GamesService } from 'src/games/games.service';
import { QuestionSchema } from 'src/questions/question.model';
import { QuestionsController } from 'src/questions/questions.controller';
import { QuestionsService } from 'src/questions/questions.service';
import { ChoicesController } from 'src/choices/choice.controller';
import { ChoiceSchema } from 'src/choices/choices.model';
import { ChoicesService } from 'src/choices/choices.service';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: 'Leaderboard', schema: LeaderBoardSchema }]),
    MongooseModule.forFeature([{ name: 'User', schema: UserSchema }]),
    MongooseModule.forFeature([{ name: 'Game', schema: GameSchema }]),
    MongooseModule.forFeature([{ name: 'Question', schema: QuestionSchema }]),
    MongooseModule.forFeature([{ name: 'Choice', schema: ChoiceSchema }]),
  ],
  controllers: [LeaderboardsController,UsersController,GamesController,QuestionsController,ChoicesController],
  providers: [LeaderboardsService,UsersService,GamesService,QuestionsService,ChoicesService],
})
export class LeaderboardsModule {}