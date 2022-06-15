$(document).on('turbolinks:load', function () {
    append_comment = function(data) {
        if ($("#comment-" + data.comment_parent + data.comment.id)[0] != null) {
            return;
        }
        elem = document.getElementById('comments-' + data.comment_parent + '-' + data.parent_id);
        console.log(data.comment)
        $(elem).append( data.comment);
    };
    App.cable.subscriptions.create("CommentsChannel", {
        connected: function() {
            return this.follow();
        },
        follow: function() {
            const QuestionId = $('.question')[0].id

            console.log($('.question')[0].id)
            console.log($('.question')[0])

            return this.perform('follow', {
                question_id: QuestionId
            });
        },
        received: function(data) {

            return append_comment(data);
        }
    });
});
