function setupCountry(country)
{
	tableRows[3].children[1].innerHTML = '<img src="/flags/4x3/' +
		country.CODE2.toLowerCase() +
		'.svg" alt="" class="countryflag"> ' +
		country.NICKNAME;
}
function setupTeam(team)
{
	tableRows[0].children[1].innerHTML = team.name;
	document.getElementsByClassName("mt-3")[0].innerHTML = team.name;
	tableRows[1].children[1].innerHTML = team.category;
	tableRows[2].children[1].innerHTML = team.affiliation;
	tableRows[4].children[1].innerHTML = team.location;
	const countryCode = team.country;
	const request = new XMLHttpRequest();
	request.open('GET', '/api/country/' + countryCode);
	request.send();
	request.onreadystatechange = function ()
	{
		if (this.readyState === 4 && this.status === 200)
		{
			setupCountry(JSON.parse(request.responseText));
		}
	}
}

const pathname = window.location.href;
// /public/team/{id}
const teamid = parseInt(pathname.split('/').pop());
const tableStriped = document.getElementsByClassName("table-striped")[0];
const tableBody = tableStriped.children[0];
const tableRows = tableBody.children;
// tableRows[0]

let request = new XMLHttpRequest();
request.open('GET', '/api/team/' + teamid);
request.send();
request.onreadystatechange = function ()
{
	if (this.readyState === 4 && this.status === 200)
	{
		const team = JSON.parse(this.responseText);
		setupTeam(team);
	}
}

