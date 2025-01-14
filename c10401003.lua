local cm,m,o=GetID()
function cm.initial_effect(c)
	vgf.VgCard(c)
	vgd.EffectTypeTrigger(c,m,LOCATION_MZONE,EFFECT_TYPE_SINGLE,EVENT_ATTACK_ANNOUNCE,cm.op,vgf.DamageCost(1),vgf.VMonsterCondition)
end
function cm.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetOverlayCount()
	if ct>=5 then Duel.Draw(tp,1,REASON_EFFECT) end
	if ct>=10 then
		vgf.AtkUp(c,c,10000,nil,nil,EFFECT_TYPE_SINGLE,EVENT_BATTLED)
		vgf.StarUp(c,c,1,nil,nil,EFFECT_TYPE_SINGLE,EVENT_BATTLED)
	end
	if ct>=15 then
		local g1=Duel.GetMatchingGroup(vgf.RMonsterFilter,tp,LOCATION_MZONE,0,nil)
		local g2=Duel.GetMatchingGroup(vgf.RMonsterFilter,tp,0,LOCATION_MZONE,nil)
		local tc1=vgf.GetVMonster(tp)
		local tc2=vgf.GetVMonster(1-tp)
		for tc in vgf.Next(g1) do
			local og=tc:GetOverlayGroup()
			if og:GetCount()>0 then
				Duel.Overlay(tc1,og)
			end
		end
		for tc in vgf.Next(g2) do
			local og=tc:GetOverlayGroup()
			if og:GetCount()>0 then
				Duel.Overlay(tc2,og)
			end
		end
		Duel.Overlay(tc1,g1)
		Duel.Overlay(tc2,g2)
		if vgf.GetAvailableLocation(tp)>0 then
			local g=tc1:GetOverlayGroup():FilterSelect(tp,Card.IsCanBeSpecialSummoned,tp,0,2,nil,e,0,tp,false,false,POS_FACEUP_ATTACK)
			vgf.Call(g,0,tp)
		end
	end
end