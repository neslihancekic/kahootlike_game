import * as mongoose from 'mongoose';

export const ChoiceSchema = new mongoose.Schema({
        questionId: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'Question',
            required: true
        },
        choiceText: {
            type: String,
            maxlength: 75,
            required: true 
        },
        isCorrectAnswer: {
            type: Boolean,
            required: true,
            default: false
        },
        order: {
            type: Number,
            min:1,
            max:4
        },
    },
    {timestamps: true}
);

export interface Choice extends mongoose.Document {
  id: string;
  questionId: string;
  choiceText: string;
  isCorrectAnswer: boolean;
  order: number;
}