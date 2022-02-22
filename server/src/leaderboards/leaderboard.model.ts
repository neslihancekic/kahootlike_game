import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Type } from 'class-transformer';
import mongoose from 'mongoose';
import { Document } from 'mongoose';
import { Choice, ChoiceDocument, ChoiceSchema } from 'src/choices/choices.model';
import { Game } from 'src/games/game.model';
import { User } from 'src/users/user.model';

export type LeaderBoardDocument = LeaderBoard & Document;

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
export class LeaderBoard {
  @Prop({ type: mongoose.Schema.Types.ObjectId, ref: 'Game',  required: true })
  @Type(() => Game)
  gameId: Game;

  @Prop({ type: mongoose.Schema.Types.ObjectId, ref: 'User',  required: true })
  @Type(() => User)
  userId: User;

  @Prop({})
  point: number;

  @Prop({default:false})
  isFinished: boolean;

  @Type(() => User)
  user: User;

}
const LeaderBoardSchema = SchemaFactory.createForClass(LeaderBoard);

LeaderBoardSchema.virtual('user', {
    ref: 'User',
    localField: 'userId',
    foreignField: '_id',
});

export { LeaderBoardSchema };

