import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);