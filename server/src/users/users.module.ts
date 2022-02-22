import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';


import { GamesController } from 'src/games/games.controller';
import { GamesService } from 'src/games/games.service';
import { GameSchema } from 'src/games/game.model';
import { ChoicesService } from 'src/choices/choices.service';
import { QuestionsService } from 'src/questions/questions.service';
import { QuestionSchema } from 'src/questions/question.model';
import { ChoiceSchema } from 'src/choices/choices.model';
import { QuestionsController } from 'src/questions/questions.controller';
import { ChoicesController } from 'src/choices/choice.controller';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { UserSchema } from './user.model';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: 'User', schema: UserSchema }]),
    MongooseModule.forFeature([{ name: 'Game', schema: GameSchema }]),
    MongooseModule.forFeature([{ name: 'Question', schema: QuestionSchema }]),
    MongooseModule.forFeature([{ name: 'Choice', schema: ChoiceSchema }]),
  ],
  controllers: [UsersController,GamesController,QuestionsController,ChoicesController],
  providers: [UsersService,GamesService,QuestionsService,ChoicesService],
})
export class UsersModule {}