library;

import 'dart:convert';
import 'package:caremixer_test/api_library/api_exceptions/caremixer_api_exceptions.dart';
import 'package:http/http.dart' as http;
 
 part '../api_endpoints/api_pokemon_list_endpoint.dart';

/// The JSON serializable model for the API response.
typedef JSON = Map<String, dynamic>;

/// When de API response is a List of [JSON]
typedef JSONLIST = List<JSON>;

/// A class to make it easier to handle the response from the API.
extension Result on http.Response {
  /// Returns true if the response is a success.
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Returns true if the response is a failure.
  bool get isFailure => !isSuccess;
}


class CaremixerApiBase {


  CaremixerApiBase();

//Instance of the http Client
//-----------------------------------
  final _httpClient = http.Client();
//-----------------------------------


  final String _baseUrl ="pokeapi.co";



//Api call headers
//--------------------------------------------------------
  Map<String, dynamic> get _apiHeaders => <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Accept-Encoding': 'gzip, deflate,br',
        'Connection': 'keep-alive'
      };
//--------------------------------------------------------

  Future<T> get<T>(Uri uri, {Map<String, dynamic>? extraHeaders}) => _get(uri, extraHeaders: extraHeaders);


//----------------------------------------------------------------------------------------------
  Future<T> _post<T>(Uri uri,
      {Map<String, dynamic>? body,
      List<Map<String, dynamic>>? bodyList,
      Map<String, dynamic>? extraHeaders}) async {

    http.Response response;

    try {
      response = await _httpClient.post(uri,
          body: body != null
              ? jsonEncode(body)
              : bodyList != null
                  ? jsonEncode(bodyList)
                  : null,
          headers: {
            ..._apiHeaders,
            ...?extraHeaders,
          });
    } catch (error) {
      throw HttpException();
    }

    if (response.isFailure) {
      _handleException(response);
    }

    return _handleResponse(response);
  }
  //----------------------------------------------------------------------------------------------


  //----------------------------------------------------------------------------------------------
  Future<T> _get<T>(Uri uri, {Map<String, dynamic>? extraHeaders}) async {
    http.Response response;
    try {
      response = await _httpClient.get(
        uri,
        headers: {
          ..._apiHeaders,
          ...?extraHeaders,
        },
      );
    } catch (error) {
      throw HttpException();
    }
    
    if (response.isFailure) {
      _handleException(response);
    }
    return _handleResponse<T>(response);
  }
  
  //----------------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------------------
  Future<T> _getFile<T>(Uri uri, {Map<String, dynamic>? extraHeaders}) async {
    http.Response response;
    try {
      response = await _httpClient.get(
        uri,
        headers: {
          ..._apiHeaders,
          ...?extraHeaders,
        },
      );
    } catch (error) {
      throw HttpException();
    }

    if (response.isFailure) {
      _handleException(response);
    }
    return _handleBytesResponse<T>(response);
  }
  //----------------------------------------------------------------------------------------------

  //----------------------------------------------------------------------------------------------
  Future<T> _delete<T>(Uri uri, {Map<String, dynamic>? extraHeaders}) async {

    http.Response response;

    try {
      response = await _httpClient.delete(
        uri,
        headers: {
          ..._apiHeaders,
          ...?extraHeaders,
        },
      );
    } catch (error) {
      throw HttpException();
    }

    if (response.isFailure) {
      _handleException(response);
    }

    return _handleResponse<T>(response);
  }
  //----------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------
  Future<T> _put<T>(Uri uri,
      {Map<String, dynamic>? body, Map<String, dynamic>? extraHeaders}) async {

    http.Response response;

    try {
      response = await _httpClient
          .put(uri, body: body != null ? jsonEncode(body) : null, headers: {
        ..._apiHeaders,
        ...?extraHeaders,
      });
    } catch (error) {
      throw HttpException();
    }

    if (response.isFailure) {
      _handleException(response);
    }
    return _handleResponse(response);
  }
  //----------------------------------------------------------------------------------------------


  //----------------------------------------------
  void _handleException(http.Response response) {
    throw HttpRequestFailure(
      response.statusCode,
      response.reasonPhrase ?? '',
      response.body,
    );
  }
  //-----------------------------------------------


  //--------------------------------------------------------------------
  T _handleResponse<T>(http.Response response) {
    if (response.body.isEmpty) {
      return response as T;
    } else {
      try {
        final dynamic decodedResponse = jsonDecode(response.body);
        if (response.isFailure && decodedResponse is Map<String, dynamic>) {
          _handleException(response);
        }
        if (decodedResponse is T) return decodedResponse;

        try {
          if (T == JSON) {
            (decodedResponse as Map).cast<String, dynamic>() as T;
          } else if (T == JSONLIST) {
            final newResponse = (decodedResponse as List)
                .map<JSON>(
                  (dynamic item) => (item as Map).cast<String, dynamic>(),
                )
                .toList();
            return newResponse as T;
          }
          return decodedResponse as T;
        } catch (_) {
          throw const SpecifiedTypeNotMatchedException();
        }
      } on FormatException {
        throw const JsonDecodeException();
      }
    }
  }
  //--------------------------------------------------------------------

  T _handleBytesResponse<T>(http.Response response) {
    if (response.bodyBytes.isEmpty) {
      return response as T;
    }

    return response.bodyBytes as T;
  }

}