
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Type } from 'class-transformer';
import mongoose from 'mongoose';
import { Document } from 'mongoose';
import { Question, QuestionSchema } from 'src/questions/question.model';

export enum GameState {
    Waiting=10,
    InProgress=20,
    Done=30
}
export type GameDocument = Game & Document;

@Schema({
    toJSON: {
      getters: true,
      virtuals: true,
    }
  })
export class Game {
  @Prop({ required: true })
  title: string;

  @Prop({ required: true })
  description: string;

  @Prop({ maxlength: 8 })
  pin: number;

  @Prop({
    enum: GameState, 
    required: true, 
    default:GameState.Waiting})
  state: number;

  @Type(() => Question)
  questions: Question[];

}

const GameSchema = SchemaFactory.createForClass(Game);

GameSchema.virtual('questions', {
    ref: 'Question',
    localField: '_id',
    foreignField: 'gameId',
});
   
export { GameSchema };
