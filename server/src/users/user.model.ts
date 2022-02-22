import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Type } from 'class-transformer';
import mongoose from 'mongoose';
import { Document } from 'mongoose';
import { Choice, ChoiceDocument, ChoiceSchema } from 'src/choices/choices.model';
import { Game } from 'src/games/game.model';

export type UserDocument = User & Document;

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
export class User {
  @Prop({ type: mongoose.Schema.Types.ObjectId, ref: 'Game',  required: true })
  @Type(() => Game)
  playingGameId: Game;

  @Prop({ required: true })
  nickname: string;

  @Prop({ required: true })
  isHost: boolean;

}
const UserSchema = SchemaFactory.createForClass(User);

export { UserSchema };
