const testServiceMode = true;
bool debugMode = false;
const my_jobs = 'Việc làm của tôi';
const my_hirings = 'Tôi thuê tư vấn';
const all = 'Tất cả';
const matching = 'Ghép cặp';

const chat_room_type = <String>[
  all,
  my_jobs,
  my_hirings,
  matching,
];

const int limitItems = 3;

const message_numPerPage = 20;

const limitPage = 1000000;
const chatRoomPerPage = 20;
const applyPerPage = 30;
const notificationPerPage = 50;
const chat_search_user_min = 10;
const chat_search_user_max = 50;

const defaultAvatar =
    'https://res.cloudinary.com/dc8kxjddi/image/upload/v1676186304/avatar_man_oicegg.gif';
const String errorMessageDefault = 'error';
const String successMessageDefault = 'success';
const clientErrorDefault = 'Đã xảy ra lỗi';
const clientSuccessDefault = 'Thành công';

class APPLY_TIMELINE_STATE {
  static const String WATCHED = 'watched';
  static const String INVITED = 'invited';
  static const String ACCEPTED = 'accepted';
  static const String REJECTED = 'rejected';
}

class APPLY_STATE {
  static const String WAITING = 'waiting';
  static const String ACCEPTED = 'accepted';
  static const String DONE = 'done'; // "accepted" => "done"
  static const String DECLINED = "declined";
}

class CONSULTING_JOB_TIMELINE_STATE {
  static const String STARTED = 'started';
  static const String FINISHED = 'finishded';
  static const String PAID = 'paid';
  static const String REVIEW = 'review';
}

class CHAT_ROOM_TYPE {
  static String JOB = 'job';
  static String MATCHING = 'matching';
}

class DELETE_STATE {
  static String NONE = 'none';
  static String BIN = 'bin';
  static String REMOVE_FROM_BIN = 'remove_from_bin';
}

class DEFAULT {
  static String EMPTY_STRING = 'none';
  static String REMOVE_REF_FIELD = 'remove_ref_field';
}

class CONSULTING_JOB_ACTION_STATE {
  static String WANT = 'want';
  static String DECLINED = "declined";
  static String ACCEPTED = 'accepted';
  static String NONE = 'none';
}

class CONSULTING_JOB_ACTION_STATE_TYPE_NAME {
  static String CLOSE = 'closeState';
  static String START = "startState";
  static String PAY = "payState";
}

List<String> applicationChoices = [
  'Tất cả',
  'Bị từ chối',
  'Đã chấp nhận',
  'Đã hoàn thành',
  'Đang chờ',
];
var applicationChoicesValues = {
  'Tất cả': null,
  'Bị từ chối': APPLY_STATE.DECLINED,
  'Đã chấp nhận': APPLY_STATE.ACCEPTED,
  'Đã hoàn thành': APPLY_STATE.DONE,
  'Đang chờ': APPLY_STATE.WAITING,
};

List<String> applicationChoicesInPost = [
  'Tất cả',
  'Deal giá',
  'Chấp nhận giá',
];

var applicationChoicesInPostValues = {
  'Tất cả': null,
  'Deal giá': NEGOTIATEPRICE_OPTION.DEAL,
  'Chấp nhận giá': NEGOTIATEPRICE_OPTION.ACCEPTED,
};

class NEGOTIATEPRICE_OPTION {
  static String DEAL = 'deal';
  static String ACCEPTED = 'accepted';
}

String avatarForServerNotifi =
    "https://res.cloudinary.com/du7jhlk4c/image/upload/v1684805057/heart_e5g6pf.png";

class NOTIFICATION_TYPE {
  static String JOB = 'job';
  static String HIRING = 'hiring';
  static String MATCHING = 'matching';
  static String CHAT = 'chat';
  static String FREE_POST = 'free_post';
}

class PAGE_NAME {
  static String CHAT_PAGE = 'chat_page';
  static String APPLICATION = 'application';
  static String APPLICATION_IN_POST = 'application_in_post';
}

class CALL_TYPE {
  static String VIDEO = 'video';
  static String AUDIO = 'audio';
}

class MESSAGE_TYPE {
  static const String IMAGE = 'image';
  static const String TEXT = 'text';
  static const String STATUS = 'status';
  static const String CALL_FAILED = 'call_failed';
  static const String CALL_SUCCESS = 'call_success';
}

const String access_token = "access-token";
const String refresh_token = "refresh-token";
