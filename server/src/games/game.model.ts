import * as mongoose from 'mongoose';

export enum GameState {
    Ready=10,
    Waiting=20,
    InProgress=30,
    Done=40
}

export const GameSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true 
    },
    description: {
        type: String,
        required: true
    },
    pin: {
        type: Number,
        required: true,
        maxlength: 8
    },
    state: { 
        type: Number,
        enum: GameState, 
        required: true, 
        default:GameState.Ready
    },
},
{timestamps: true});

export interface Game extends mongoose.Document {
  id: string;
  title: string;
  description: string;
  pin: number;
  state: number;
}