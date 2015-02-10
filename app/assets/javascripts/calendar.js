$(document).on("page:load ready", function() {
    var eventsSource = 'events';
    $('#calendar').fullCalendar({
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek,basicDay'
        },
        eventLimit: true, // allow "more" link when too many events
        events: {
            url: 'events',
            data: function() {
                return {
                    all: $('#showAll').is(':checked')
                };
            }
        },
        dayClick: function(date) {
            top.date = date;
            $("#new_link")[0].click();
        },
        eventClick: function(event){
            $('#edit_link').attr('href', "/events/"+event.id+"/edit");
            $('#edit_link')[0].click();
        }
    });
    $('#showAll').on('click', function(){
        if ($('#showAll').is(':checked')) {
            eventsSource = 'events?all=true';
        } else {
            eventsSource = 'events'
        }
        $('#calendar').fullCalendar('refetchEvents');
    });
});



