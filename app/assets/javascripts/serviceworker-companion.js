// Initialize Firebase
var config = {
  apiKey: "AIzaSyAtn5G5ilkWsB8OxXvgM8_IftdhS76BoM0",
  authDomain: "bookreptokyo.firebaseapp.com",
  databaseURL: "https://bookreptokyo.firebaseio.com",
  projectId: "bookreptokyo",
  storageBucket: "bookreptokyo.appspot.com",
  messagingSenderId: "897475029863"
};

messaging = firebase.initializeApp(config).messaging();
messaging.requestPermission();

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js', { scope: './' })
  .then(() => {
    return navigator.serviceWorker.ready;
}).then(regist => {
    messaging.useServiceWorker(regist);
    messaging.requestPermission().then(() => {
        messaging.getToken().then(token => {
            //console.log(token);
            params = {
              token: token
            }
            $.ajax({
              type: 'POST',
              url: '/push_notifications',
              data: params
            });

        });
    });
});
  // .then(function(registration) {
  //       //console.log('[Companion]', 'Service worker registered!');
  //
  //       return registration.pushManager.getSubscription().then(function(subscription) {
  //         if (subscription) {
  //           return subscription
  //         }
  //         return registration.pushManager.subscribe({
  //           userVisibleOnly: true
  //         })
  //       })
  //   }).then(function(subscription) {
  //       console.log(subscription)
  //       console.log("pushManager endpoint:", subscription.endpoint)
  //       params = {
  //         subscription: subscription.toJSON()
  //       }
  //       $.ajax({
  //         type: 'POST',
  //         url: '/push_notifications',
  //         data: params
  //       });
  //     }).catch(function(error) {
  //       console.warn("serviceWorker error:", error)
  //     });
}
// if (navigator.serviceWorker) {
//   navigator.serviceWorker.register('/serviceworker.js', { scope: './' })
//     .then(function(reg) {
//       console.log('[Page] Service worker registered!');
//
//       // プッシュ通知の購読
//       reg.pushManager.subscribe({
//         userVisibleOnly: true,
//         applicationServerKey: window.ENV.vapidPublicKey,
//       }).then(subscribeSuccess);
//     });
// }
//
// var subscribeSuccess = function(subscription){
//   params = {
//     subscription: subscription.toJSON();
//   }
//
//   $.ajax({
//     type: 'POST',
//     url: '/devices',
//     data: params
//   });
// }
