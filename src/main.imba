import * as MA from 'imba-material-icons'
import * as PH from 'imba-phosphor-icons'
import * as CO from 'imba-codicons'

let icons = {}
for own k,v of MA
	icons['MATERIAL.' + k] = v
for own k,v of PH
	icons['PHOSPHOR.' + k] = v
for own k,v of CO
	icons['CODICONS.' + k] = v

extend class String
	get has do includes
	get lower do toLowerCase!

global css svg
	* fill:currentColor
	[fill] fill:none
	[stroke] stroke:currentColor

tag app

	show-items = 10
	query = ''

	def copy text
		await window.navigator.clipboard.writeText(text)
		copied? = yes
		setTimeout(&,1s) do
			copied? = no
			imba.commit!

	<self @hotkey('esc').force=(query = '')>
		css inset:0 d:vtl c:warm2 bg:warm8 ff:Arial p:3 g:3 of:auto

		<div>
			css d:hcl g:3

			<input$i @blur=$i.focus bind=query autofocus>
				css bg:none ol:none bd:1px solid white rd:3 c:white py:2 px:3 fs:lg

			if copied?
				<div>
					css c:emerald4
					"COPIED"

		<div>
			css d:vtl g:3

			let i = 0
			for own k,v of icons when i < show-items
				continue unless k.lower.has(query.lower.trim!)
				i += 1
				<div @click=copy(k)>
					css d:vtl g:3
					<div[us:none]> k
					<svg[s:30px] src=icons[k]>
			<div @intersect.in=(show-items += 10)>
				css h:40px w:100%

imba.mount <app>
