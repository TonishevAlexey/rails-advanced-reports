console.log("22222")

$(document).on('turbolinks:load', function () {
    console.log("1111")
    $('.answers').on('click', '.edit-answer-link', function (e) {
        e.preventDefault();
        console.log("plus")
        var answerId = $(this).data('answer-id');
        $('form#edit-answer-' + answerId).removeClass('hidden');
    })
});