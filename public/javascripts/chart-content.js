var chart;
$(document).ready(function() {
	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'ages-group',
			defaultSeriesType: 'column'
		},
		title: {
			text: 'Estimates by age group 26-35'
		},
		xAxis: {
			categories: ['1', '10', '100', '1000']
		},
		yAxis: {
			title: {
				text: 'Number of Responses'
			}
		},
		tooltip: {
			formatter: function() {
				return '' + this.y +' users responded with '+ this.x.toLowerCase();
			}
		},
		plotOptions: {
			column: {
				data: 'data-ages-group',
				// define a custom data parser function for both series
				dataParser: function(data) {
					var table = document.getElementById(data),
						// get the data rows from the tbody element
						rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr'),
						// define the array to hold the real data
						result = [], 
						// decide which column to use for this series
						column = { 'Count': 0 }[this.options.name];
						
					// loop through the rows and get the data depending on the series (this) name
					for (var i = 0; i < rows.length; i++) {						
						result.push(
							parseInt(
								rows[i].getElementsByTagName('td')[column]. // the data cell
								innerHTML
							)
						);
					}
					return result;
				}
			}
		},
		credits: {
			enabled: false
		},
		legend: {
			enabled: false
		},
		series: [{
			name: 'Count'
		}]
	});
	
	
});

var chart;
$(document).ready(function() {
	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'ages-all',
			defaultSeriesType: 'column'
		},
		title: {
			text: 'Estimates for all ages'
		},
		xAxis: {
			categories: ['1', '10', '100', '1000']
		},
		yAxis: {
			title: {
				text: 'Number of Responses'
			}
		},
		tooltip: {
			formatter: function() {
				return '' + this.y +' users responded with '+ this.x.toLowerCase();
			}
		},
		plotOptions: {
			column: {
				data: 'data-ages-all',
				// define a custom data parser function for both series
				dataParser: function(data) {
					var table = document.getElementById(data),
						// get the data rows from the tbody element
						rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr'),
						// define the array to hold the real data
						result = [], 
						// decide which column to use for this series
						column = { 'Count': 0 }[this.options.name];
						
					// loop through the rows and get the data depending on the series (this) name
					for (var i = 0; i < rows.length; i++) {						
						result.push(
							parseInt(
								rows[i].getElementsByTagName('td')[column]. // the data cell
								innerHTML
							)
						);
					}
					return result;
				}
			}
		},
		credits: {
			enabled: false
		},
		legend: {
			enabled: false
		},
		series: [{
			name: 'Count'
		}]
	});
	
	
});

var chart;
$(document).ready(function() {
	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'gender-group',
			defaultSeriesType: 'column'
		},
		title: {
			text: 'Estimates by males'
		},
		xAxis: {
			categories: ['Male', 'Female', 'Unknown']
		},
		yAxis: {
			title: {
				text: 'Number of Responses'
			}
		},
		tooltip: {
			formatter: function() {
				return '' + this.y +' users responded with '+ this.x.toLowerCase();
			}
		},
		plotOptions: {
			column: {
				data: 'data-gender-group',
				// define a custom data parser function for both series
				dataParser: function(data) {
					var table = document.getElementById(data),
						// get the data rows from the tbody element
						rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr'),
						// define the array to hold the real data
						result = [], 
						// decide which column to use for this series
						column = { 'Count': 0 }[this.options.name];
						
					// loop through the rows and get the data depending on the series (this) name
					for (var i = 0; i < rows.length; i++) {						
						result.push(
							parseInt(
								rows[i].getElementsByTagName('td')[column]. // the data cell
								innerHTML
							)
						);
					}
					return result;
				}
			}
		},
		credits: {
			enabled: false
		},
		legend: {
			enabled: false
		},
		series: [{
			name: 'Count'
		}]
	});
	
	
});

var chart;
$(document).ready(function() {
	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'gender-all',
			defaultSeriesType: 'column'
		},
		title: {
			text: 'Estimates for all genders'
		},
		xAxis: {
			categories: ['Male', 'Female', 'Unknown']
		},
		yAxis: {
			title: {
				text: 'Number of Responses'
			}
		},
		tooltip: {
			formatter: function() {
				return '' + this.y +' users responded with '+ this.x.toLowerCase();
			}
		},
		plotOptions: {
			column: {
				data: 'data-gender-all',
				// define a custom data parser function for both series
				dataParser: function(data) {
					var table = document.getElementById(data),
						// get the data rows from the tbody element
						rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr'),
						// define the array to hold the real data
						result = [], 
						// decide which column to use for this series
						column = { 'Count': 0 }[this.options.name];
						
					// loop through the rows and get the data depending on the series (this) name
					for (var i = 0; i < rows.length; i++) {						
						result.push(
							parseInt(
								rows[i].getElementsByTagName('td')[column]. // the data cell
								innerHTML
							)
						);
					}
					return result;
				}
			}
		},
		credits: {
			enabled: false
		},
		legend: {
			enabled: false
		},
		series: [{
			name: 'Count'
		}]
	});
	
	
});
