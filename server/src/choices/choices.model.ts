import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Type } from 'class-transformer';
import mongoose from 'mongoose';
import { Document } from 'mongoose';
import { Question } from 'src/questions/question.model';

export type ChoiceDocument = Choice & Document;

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
export class Choice {
  @Prop({ type: mongoose.Schema.Types.ObjectId, ref: 'Question',  required: true })
  @Type(() => Question)
  questionId: Question;
 
  @Prop({ required: true,
    maxlength: 75, })
  choiceText: string;


  @Prop({ required: true, default: false })
  isCorrectAnswer: boolean;

  @Prop({ min:1, max:4})
  order: number;


}

export const ChoiceSchema = SchemaFactory.createForClass(Choice);

   