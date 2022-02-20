import { SubscribeMessage, WebSocketGateway, OnGatewayInit, WebSocketServer, OnGatewayConnection } from '@nestjs/websockets';
import { Socket, Server } from 'socket.io';
import { Logger } from '@nestjs/common';

@WebSocketGateway({ namespace: '/event' })
export class EventGateway implements OnGatewayInit {

  @WebSocketServer() wss: Server;

  private logger: Logger = new Logger('EventGateway');

  afterInit(server: any) {
    this.logger.log('Initialized!');
  }

  @SubscribeMessage('eventToServer')
  handleMessage(client: Socket, message: { sender: string, game: string, message: string }) {
    this.wss.to(message.game).emit('eventToClient', message);
  }

  @SubscribeMessage('joinGame')
  handleGameJoin(client: Socket, game: string ) {
    client.join(game);
    client.emit('joinedGame', game);
  }

  @SubscribeMessage('leaveGame')
  handleGameLeave(client: Socket, game: string ) {
    client.leave(game);
    client.emit('leftGame', game);
  }

}
