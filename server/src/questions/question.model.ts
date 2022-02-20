import * as mongoose from 'mongoose';


enum QuestionType {
    Quiz=10,
    TrueFalse=20,
    TypeAnswer=30,
    Puzzle=40
}

export const QuestionSchema = new mongoose.Schema({   
        gameId: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'Game',
            required: true
        },
        questionText: {
            type: String,
            required: true 
        },
        questionPhoto: {
            type: String,
            required: true 
        },
        questionPoint: {
            type: Number,
            default: 10,
            required: true 
        },
        timeLimit: {
            type: Number,
            default: 20,
            required: true 
        },
        isMultiSelect: {
            type: Boolean,
            required: true
        },
        type: { 
            type: Number,
            enum: QuestionType, 
            required: true, 
            default:QuestionType.Quiz
        }
    },
    {timestamps: true}
);

export interface Question extends mongoose.Document {
  id: string;
  gameId: string;
  questionText: string;
  questionPhoto: string;
  questionPoint: number;
  timeLimit: number;
  isMultiSelect: boolean;
  type: number;
}