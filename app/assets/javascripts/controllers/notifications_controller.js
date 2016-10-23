this.window[APP_NAME].controller("NotificationsController",["$scope","$http","$pusher",function(t,n,e){var i,o,a,r,c,u,s;return o=["exam","appointment","surgery"],i=["Exame","Consulta","Cirurgia"],t.showComments={},a=function(){var n;return t.getAllNotifications(),n=e(new Pusher(PUSHER_KEY)),s(n),u(n)},s=function(n){var e;return e=n.subscribe("notification_channel"),e.bind("new_notification",function(n){return t.notifications.unshift(n)})},u=function(n){var e;return e=n.subscribe("comment_channel"),e.bind("new_comment",function(n){return t.notifications[t.notifications.indexOf(c(n.notification_id))].comments?t.notifications[t.notifications.indexOf(c(n.notification_id))].comments.unshift(n):t.notifications[t.notifications.indexOf(c(n.notification_id))].comments=[n]})},c=function(n){var e;return e={},t.notifications.forEach(function(t,i){t.id===n&&(e=t)}),e},t.getAllNotifications=function(){return n({url:"/api/v1/notifications.json?user_id=:user_id".replace(":user_id",USER_ID),method:"get"}).success(function(n){return t.notifications=n.notifications})},t.getNotificationsByCategory=function(e){return n({url:"/api/v1/notifications.json?user_id=:user_id&category=:category".replace(":user_id",USER_ID).replace(":category",e),method:"get"}).success(function(n){return t.notifications=n.notifications})},t.getNotificationsBySearch=function(e){var i;return e.preventDefault(),i=angular.element(e.target).find('input[name="notification[note]"]')[0].value,n({url:"/api/v1/notifications/search.json?user_id=:user_id&note=:note".replace(":user_id",USER_ID).replace(":note",i),method:"get"}).success(function(n){return n.notifications.length>0?(angular.element(".filter-radio")[0].checked=!0,t.notifications=n.notifications):t.notifications=[]})},t.getNotificationCategorySlug=function(t){return o[t]},t.getNotificationCategoryName=function(t){return i[t]},t.createNotification=function(e){var i,o;return e.preventDefault(),i=0===angular.element(e.target).find('input[name="notification[category]"]:checked').length?"":angular.element(e.target).find('input[name="notification[category]"]:checked')[0].value,o={authenticity_token:angular.element(e.target).find("input[name=authenticity_token]")[0].value,notification:{category:i,note:angular.element(e.target).find('textarea[name="notification[note]"]')[0].value,user_id:angular.element(e.target).find('input[name="notification[user_id]"]')[0].value}},n({url:"/api/v1/notifications.json?user_id=:user_id".replace(":user_id",USER_ID),method:"post",data:o}).success(function(n){return n.success?(t.errors={},r(e),$("html, body").animate({scrollTop:0})):t.errors=n.errors})},r=function(t){return angular.element(t.target).find('input[name="notification[category]"]:checked')[0].checked=!1,angular.element(t.target).find('textarea[name="notification[note]"]')[0].value=""},t.deleteNotification=function(e,i){return e.preventDefault(),n({url:"/api/v1/notifications/:id.json?user_id=:user_id".replace(":id",i.id).replace(":user_id",USER_ID),method:"delete"}).success(function(n){if(n.success)return t.notifications.splice(t.notifications.indexOf(i),1)})},t.confirmNotification=function(e,i){var o;return e.preventDefault(),o={notification:{confirmed:!i.confirmed}},n({url:"/api/v1/notifications/:id.json?user_id=:user_id".replace(":id",i.id).replace(":user_id",USER_ID),method:"put",data:o}).success(function(n){if(n.success)return t.notifications[t.notifications.indexOf(i)]=n.notification})},t.toggleComments=function(t){if(t.showComments=!t.showComments,t.showComments)return n({url:"/api/v1/comments.json?notification_id=:notification_id".replace(":notification_id",t.id),method:"get"}).success(function(n){if(n.comments.length>0)return t.comments=n.comments})},t.createComment=function(t,e){var i;return t.preventDefault(),i={authenticity_token:angular.element(t.target).find("input[name=authenticity_token]")[0].value,comment:{comment:angular.element(t.target).find('textarea[name="comment[comment]"]')[0].value,notification_id:e.id,user_id:USER_ID}},n({url:"/api/v1/comments.json",method:"post",data:i}).success(function(t){return t.success?(e.comment_errors={},angular.element('textarea[name="comment[comment]"]')[0].value=""):e.comment_errors=t.errors})},a()}]);