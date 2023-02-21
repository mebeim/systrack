const table = document.getElementsByTagName('table')[0]

function sortTable(e) {
	const header = e.target
	const idx    = Array.from(header.parentNode.children).indexOf(e.target)
	const rows   = Array.from(table.querySelectorAll('tr')).slice(1)
	const desc   = header.classList.contains('ascending')
	const body   = rows[0].parentElement
	let getValue

	if (idx === 0) {
		getValue = el => parseInt(el.children[0].textContent, 16)
	} else {
		// The "number" header spans two columns (for decimal and hexadecimal)
		getValue = el => el.children[idx + 1].textContent
	}

	rows.forEach(el => body.removeChild(el))
	rows.sort((a, b) => {
		let va = getValue(a)
		let vb = getValue(b)

		if (desc)
			[va, vb] = [vb, va]

		if (va > vb) return 1
		if (va < vb) return -1
		return 0
	})

	rows.forEach(el => body.appendChild(el))
	table.querySelectorAll('th').forEach(h => h.classList.remove('ascending', 'descending'))
	header.classList.add(desc ? 'descending' : 'ascending')
}

function highlightRow(e) {
	const row = e.currentTarget
	row.classList.toggle('highlight')
}

document.querySelectorAll('th.sortable').forEach(el => el.addEventListener('click', sortTable))
document.querySelectorAll('tr:not(:first-child)').forEach(el => el.addEventListener('click', highlightRow))
