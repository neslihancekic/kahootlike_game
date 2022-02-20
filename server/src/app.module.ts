import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';

//Http
import { GamesModule } from './games/games.module';
import { UsersModule } from './users/users.module';
import { QuestionsModule } from './questions/questions.module';
import { ChoicesModule } from './choices/choices.module';
import { LeaderboardsModule } from './leaderboards/leaderboards.module';
import { FilesModule } from './files/files.module';

//Web Socket
import { EventGateway } from './event/event.gateaway';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: './config/dev.env',  
      isGlobal: true,
    }),
    MongooseModule.forRoot(process.env.MONGO_URI),
    GamesModule,
    UsersModule,
    QuestionsModule,
    ChoicesModule,
    LeaderboardsModule,
    FilesModule,
    EventGateway
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
