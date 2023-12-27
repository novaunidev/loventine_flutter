/*
  DEPLOY
*/
const baseUrl = "https://loventine-apis.onrender.com";
// https://hqknqlono2223.onrender.com | http://localhost:5000

// VPS => http://103.116.9.121

const urlDeloy = baseUrl;

//LOVENTINE
const baseUrlLoventine = "https://localhost:7079";
const urlUsers = '$baseUrlLoventine/api/users';
const urlPosts = '$baseUrlLoventine/api/posts';
const urlComments = '$baseUrlLoventine/api/comments';
const urlLikes = '$baseUrlLoventine/api/likes';
const urlBookmarks = '$baseUrlLoventine/api/bookmarks';


const urlSocket_deploy = baseUrl;
const urlGetAlUser = '$baseUrl/auth/getAllUser'; // get
const urlLoginwithPhone = '$baseUrl/auth/loginwithPhone'; // post
const urlLoginwithEmail = '$baseUrl/auth/loginwithEmail';
const urlSignUp = '$baseUrl/auth/createUser'; // post

const urlCreateFreePost = '$baseUrl/post/createPost/';

const urlGetAllOtherPost =
    'https://70ff-14-161-6-190.ap.ngrok.io/post/getAllOtherPost'; // get

// message
const urlGetAllMessage = '$baseUrl/message/getAllMessageChatRoom'; // get
const urlGetMessageChatRoom = '$baseUrl/message/getMessageChatRoom/'; // get
const urlMessage = '$baseUrl/message';
// chat room
const urlChatRoom = '$baseUrl/chat_room';
const urlChatRoomGetOneWith = '$urlChatRoom/getOneWith';
// apply
const urlApply = '$baseUrl/apply';
const urlApplyUpdateState = '$urlApply/state';
// consulting_job
const urlConsultingJob = '$baseUrl/consulting_job';
const urlConsultingJobUpdateAction = '$urlConsultingJob/action';
const urlConsultingJobPaid = '$urlConsultingJob/pay';
// notifiaction
const urlNotification = '$baseUrl/notification';
// review
const urlReview = '$baseUrl/review';
// back serviec
const urlBackService = '$baseUrl/back-service';
// auth
const urlAuth = '$baseUrl/auth';
const urlAuthLogout = '$baseUrl/auth/logout';
const urlAuthCheckToken = '$baseUrl/auth/check-token';
// wallet
const urlGetWallet = '$baseUrl/user/get-wallet';
// transaction
const urlTransaction = '$baseUrl/transaction';
// bank account
const urlBankAccount = '$baseUrl/bank-account';
// bill
const urlBill = '$baseUrl/bill';
const urlBillPaid = '$urlBill/paid';
const urlBillPaidSuggest = '$urlBill/paid-suggest';
// post
const urlPost = '$baseUrl/post';
const urlPostPaymentVerified = '$urlPost/payment-verified';
const urlPostCancelPaymentVerified = '$urlPost/cancel-payment-verified';
const urlPostCheckPaymentVerified = '$urlPost/check-payment-verified';
const urlPostAutoPaymentVerified = '$urlPost/auto-payment-verified';
// bank account personal
const urlBankAccountPersonal = '$baseUrl/bank-account-personal';
// withdraw
const urlWithdrawMoney = '$baseUrl/withdraw-money';
