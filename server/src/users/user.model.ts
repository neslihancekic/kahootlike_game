import * as mongoose from 'mongoose';

export const UserSchema = new mongoose.Schema({
    nickname: {
        type: String,
        required: true 
    },
    playingGameId: {
        type: mongoose.SchemaTypes.ObjectId,
        ref: 'Game'
    },
    isHost: {
        type: Boolean,
        default: false,
        required: true
    }
},
{timestamps: true});

export interface User extends mongoose.Document {
  id: string;
  nickname: string;
  playingGameId: string;
  isHost: boolean;
}