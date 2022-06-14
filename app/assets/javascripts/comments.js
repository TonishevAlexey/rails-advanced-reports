$(document).on('turbolinks:load', function () {
    append_comment = function(data) {
        if ($("#comment-" + data.comment_parent + data.comment.id)[0] != null) {
            return;
        }
        elem = document.getElementById('comments-' + data.comment_parent + '-' + data.parent_id);

        $(elem).append( data.comment);
    };
    App.cable.subscriptions.create("CommentsChannel", {
        connected: function() {
            return this.follow();
        },
        follow: function() {
            return this.perform('follow');
        },
        received: function(data) {

            return append_comment(data);
        }
    });
});
