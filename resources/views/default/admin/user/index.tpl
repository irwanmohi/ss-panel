{include file='admin/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<link href="/assets/public/css/jquery-confirm.css" rel="stylesheet" type="text/css"/>
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            用户列表
            <small>User List</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
		<div class="row">
            <div class="col-md-12">
                <div id="msg-success" class="alert alert-info alert-dismissable" style="display: none;">
                    <button type="button" class="close" id="ok-close" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-info"></i> 成功!</h4>

                    <p id="msg-success-p"></p>
                </div>

            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="box">
                    <div class="box-body table-responsive no-padding">
                        {$users->render()}
                        <table class="table table-hover">
                            <tr>
                                <th>ID</th>
                                <th>邮箱</th>
                                <th>端口</th>
                                <th>状态</th>
                                <th>协议</th>
                                <th>混淆</th>
                                <th>加密</th>
                                <th>已用流量/总流量</th>
                                <th>最后在线时间</th>
                                <th>最后签到时间</th>
                                <th>注册时间</th>
                                <th>注册IP</th>
                                <th>邀请者</th>
                                <th>操作</th>
                            </tr>
                            {foreach $users as $user}
                            <tr>
                                <td>#{$user->id}</td>
                                <td>{$user->email}</td>
                                <td>{$user->port}</td>
                                
                                {if $user->enable==1}
                                    <td>正常</td>
								                {else}
								                    <td>禁用</td>
								                {/if}
                                
                                <td>{$user->protocol}</td>
                                <td>{$user->obfs}</td>
                                <td>{$user->method}</td>
                                <td>{$user->usedTraffic()}/{$user->enableTraffic()}</td>
                                <td>{$user->lastSsTime()}</td>
                                <td>{$user->lastCheckInTime()}</td>
                                <th>{$user->reg_date}</th>
                                <th>{$user->reg_ip}</th>
                                <th>{$user->ref_by}</th>
                                <td>
                                    <a class="btn btn-info btn-sm" href="/admin/user/{$user->id}/edit">编辑</a>
                                    <a class="btn btn-danger btn-sm" id="delete" value="{$user->id}" href="javascript:void(0);" onclick="confirm_delete({$user->id});">删除</a>
                                </td>
                            </tr>
                            {/foreach}
                        </table>
                        {$users->render()}
                    </div><!-- /.box-body -->
                </div><!-- /.box -->
            </div>
        </div>

    </section><!-- /.content -->
</div><!-- /.content-wrapper -->

<script src="/assets/public/js/jquery-confirm.js"></script>
<script type="text/javascript"> 
	function deleteuser(uid){
		$.ajax({
			type:"DELETE",
			url:"/admin/user/" + uid,
			dataType:"json",
			success:function(data){
				if(data.ret){
					$("#msg-error").hide(100);
					$("#msg-success").show(100);
					$("#msg-success-p").html(data.msg);
					window.setTimeout("location.href='/admin/user'", 2000);
				}else{
					$("#msg-error").hide(10);
					$("#msg-error").show(100);
					$("#msg-error-p").html(data.msg);
				}
			},
			error:function(jqXHR){
				$("#msg-error").hide(10);
				$("#msg-error").show(100);
				$("#msg-error-p").html("发生错误："+jqXHR.status);
			}
		});
	}
	function confirm_delete(id) {
		$.confirm({
		    title: '确认操作',
			content: '你确定要删除这个用户?',
			confirm: function(){
				deleteuser(id);
			},
			confirmButton: '是',
			cancelButton: '否'
		});
	}
    $(document).ready(function(){
        $("html").keydown(function(event){
            if(event.keyCode==13){
                login();
            }
        });
        $("#ok-close").click(function(){
            $("#msg-success").hide(100);
        });
        $("#error-close").click(function(){
            $("#msg-error").hide(100);
        });
    })
</script>

{include file='admin/footer.tpl'}
