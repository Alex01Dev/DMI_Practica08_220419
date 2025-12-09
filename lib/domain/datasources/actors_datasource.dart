import 'package:cinemapedia_220419/domain/entities/actor.dart';

abstract class ActorsDatasource {

  Future<List<Actor>> getActorsByMovie( String movieId );

}