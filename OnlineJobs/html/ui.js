var visable = true;

$(function () {
	window.addEventListener('message', function (event) {

		switch (event.data.action) {
			case 'toggle':
				if (visable) {
					$('#contador').fadeOut();
				} else {
					$('#contador').fadeIn();
				}

				visable = !visable;
				break;

			case 'close':
				$('#contador').fadeOut();
				visable = false;
				break;

			case 'updatePlayerJobs':
				var jobs = event.data.jobs;
				//$('#player_count').html(jobs.player_count);
				$('#ems').html(jobs.ems);
				$('#police').html(jobs.police);
				$('#mechanic').html(jobs.mechanic);
				$('#arcadius').html(jobs.arcadius);
				$('#cardealer').html(jobs.cardealer);
				$('#estate').html(jobs.estate);
				break;

			case 'updatePlayerList':
				$('#playerlist tr:gt(0)').remove();
				$('#playerlist').append(event.data.players);
				//applyPingColor();
				//sortPlayerList();
				break;

			case 'updateServerInfo':
				if (event.data.maxPlayers) {
					$('#max_players').html(event.data.maxPlayers);
				}
				break;
		}
	}, false);
});




