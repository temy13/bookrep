if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js', { scope: './' })
  .then(function(registration) {
        console.log('[Companion]', 'Service worker registered!');

        return registration.pushManager.getSubscription().then(function(subscription) {
          if (subscription) {
            return subscription
          }
          return registration.pushManager.subscribe({
            userVisibleOnly: true
          })
        })
    }).then(function(subscription) {
        console.log(subscription)
        console.log("pushManager endpoint:", subscription.endpoint)
      }).catch(function(error) {
        console.warn("serviceWorker error:", error)
      });
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
