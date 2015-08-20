time_base=Time.now-2.months
time_format='%Y-%m-%d'
mold_nrs=%w(GM001 GM002 GM003 MB001 MB002 MB003)
knife_types=%w(kt001 kt002 kt003 kt004 kt005)
knife_categories=%w(CW ICW CH ICH)
quantity_base=100
suppliers=%w(THB THA)
broken_statuses=%w(放行 磨损 断裂 被高宏击倒)
wear_knife_life_base=1000000
break_knife_life_base=1000000
cut_count=1000000

projects=%w(MB GM VW)
problems=%w(断裂 磨损 愤怒的高大姐)
damage_definations=%w(正常损坏 非正常损坏)
maintance_persons=%w(王朝 马汉 张龙 赵虎 还有高宏)
machine_nrs=%w(MA MB MC MD ME MF)
operators=%w(O1 O2 O3 O4 O5)
check_confirms=maintance_persons
change_sorts=%w(维修 退货)


problem_descs=%w(模具问题 切头 防水圈刺破 磨损 飘丝 S06 喇叭口跳动)
fix_ways=%w(更换 调整位置 更换上下针 清理)
codes=%w(A B C D E F G)
delivery_ways=%w(横送料 竖送料 防水圈)

loop_count=0
#KnifeSwitchRecord.unscoped.delete_all
# TotalKnifeChange.unscoped.delete_all
# TotalMantanceTime.unscoped.delete_all

loop do
  puts "loop count: #{loop_count}..........................."
  ActiveRecord::Base.transaction do

    # total knife life
    rand(5).times do
      o= KnifeSwitchRecord.create(
          switch_date: (time_base+loop_count.days).strftime(time_format),
          mould_id: mold_nrs[rand(mold_nrs.size)],
          project_id: projects[rand(projects.size)],
          knife_type: knife_types[rand(knife_types.size)],
          knife_kind: knife_categories[rand(knife_categories.size)],
          # mold_and_knife_type: "#{mold_nrs[rand(mold_nrs.size)]}#{knife_types[rand(knife_types.size)]}",
          m_qty: rand(quantity_base),
          knife_supplier: suppliers[rand(suppliers.size)],
          state: broken_statuses[rand(broken_statuses.size)],
          problem: problems[rand(problems.size)],
          damage_define: damage_definations[rand(damage_definations.size)],
          machine_id: machine_nrs[rand(machine_nrs.size)],
          operater: operators[rand(operators.size)],
          sort: change_sorts[rand(change_sorts.size)],
          outbound_id: '%07d' % rand(100000),
          #
          total_life: rand(wear_knife_life_base),
          damage_life: rand(wear_knife_life_base),
          broken_life: rand(break_knife_life_base)
      # cut_count_1: rand(cut_count),
      # cut_count_2: rand(cut_count)
      )

      puts o.to_json
    end




    #
    #
    # # total mantance times
    rand(5).times do
      o=MouldMaintainTime.create(
          project_id: projects[rand(projects.size)],
          maintain_date: (time_base+loop_count.days).strftime(time_format),
          device_id: machine_nrs[rand(machine_nrs.size)],
          mould_id: mold_nrs[rand(mold_nrs.size)],
          serviceman: maintance_persons[rand(maintance_persons.size)],
          # start_time: "#{rand(24)}:#{rand(60)}",
          # end_time: "#{rand(24)}:#{rand(60)}",
          downtime: rand(100),
          # total_time: rand(1),
          err_note: problem_descs[rand(problem_descs.size)],
          solution_method: fix_ways[rand(fix_ways.size)],
          code: codes[rand(codes.size)],
          feed_code: delivery_ways[rand(delivery_ways.size)]
      )
      puts o.to_json
    end


    loop_count+=1

    sleep(10)
  end


end
