import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Type } from 'class-transformer';
import mongoose from 'mongoose';
import { Document } from 'mongoose';
import { Choice, ChoiceDocument, ChoiceSchema } from 'src/choices/choices.model';
import { Game } from 'src/games/game.model';


enum QuestionType {
    Quiz=10,
    TrueFalse=20,
    TypeAnswer=30,
    Puzzle=40
}
export type QuestionDocument = Question & Document;

@Schema({
    toJSON: {
        getters: true,
        virtuals: true,
      }, 
      toObject:{
          getters: true,
          virtuals: true,
      }, 
  })
export class Question {
  @Prop({ type: mongoose.Schema.Types.ObjectId, ref: 'Game',  required: true })
  @Type(() => Game)
  gameId: Game;
 

  @Prop({ required: true })
  questionText: string;

  @Prop()
  questionPhoto: string;

  @Prop({ required: true, default:10 })
  questionPoint: number;

  @Prop({ required: true, default:20 })
  timeLimit: number;

  @Prop({ default: false })
  isMultiSelect: boolean;

  @Prop({
    enum: QuestionType, 
    required: true, 
    default:QuestionType.Quiz})
  type: number;

  @Type(() => Choice)
  choices: Choice[];

}
const QuestionSchema = SchemaFactory.createForClass(Question);

QuestionSchema.virtual('choices', {
    ref: 'Choice',
    localField: '_id',
    foreignField: 'questionId',
});


export { QuestionSchema };
