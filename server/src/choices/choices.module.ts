import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { ChoicesController } from './choice.controller';
import { ChoicesService } from './choices.service';
import { ChoiceSchema } from './choices.model';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: 'Choice', schema: ChoiceSchema }]),
  ],
  controllers: [ChoicesController],
  providers: [ChoicesService],
})
export class ChoicesModule {}