import * as mongoose from 'mongoose';


export const LeaderboardSchema = new mongoose.Schema({   
        gameId: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'Game',
            required: true
        },
        userId: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'User',
            required: true
        },
        point: {
            type: Number,
            default:0,
            required: true 
        }
    },
    {timestamps: true}
);

export interface Leaderboard extends mongoose.Document {
  id: string;
  gameId: string;
  userId: string;
  point: number;
}