import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { GamesController } from './games.controller';
import { GamesService } from './games.service';
import { GameSchema } from './game.model';
import { ChoicesService } from 'src/choices/choices.service';
import { QuestionsService } from 'src/questions/questions.service';
import { QuestionSchema } from 'src/questions/question.model';
import { ChoiceSchema } from 'src/choices/choices.model';
import { QuestionsController } from 'src/questions/questions.controller';
import { ChoicesController } from 'src/choices/choice.controller';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: 'Game', schema: GameSchema }]),
    MongooseModule.forFeature([{ name: 'Question', schema: QuestionSchema }]),
    MongooseModule.forFeature([{ name: 'Choice', schema: ChoiceSchema }]),
  ],
  controllers: [GamesController,QuestionsController,ChoicesController],
  providers: [GamesService,QuestionsService,ChoicesService],
})
export class GamesModule {}