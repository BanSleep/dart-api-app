abstract class StAuthorizationScreen{}

class StAuthorizationScreenInit extends StAuthorizationScreen{}

class StAuthorizationScreenLoaded extends StAuthorizationScreen{}

class StAuthorizationScreenLoading extends StAuthorizationScreen{}

class StAuthorizationScreenNoAuthError extends StAuthorizationScreen{}

class StAuthorizationScreenNoInternetError extends StAuthorizationScreen {}

class StAuthorizationScreenError extends StAuthorizationScreen{
  final int? error;
  final String? message;
  StAuthorizationScreenError({this.error,this.message});
}
    