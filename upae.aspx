<%@ Page Language="C#" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<script runat="server">

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(2000);
        lblUpdate.Text = DateTime.Now.ToString();
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>www.30sharp.com</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div style="margin-bottom: 10px;">
            <div style="border: dashed 1px #222222; width: 300px;">
                <div id="divContainer" style="background-color: white; width: 300px;">
                    <asp:UpdatePanel ID="update" runat="server">
                        <ContentTemplate>
                            <div id="background" style="text-align: center; vertical-align: middle; line-height: 44px;
                                padding: 12px; height: 44px;">
                                <asp:Label ID="lblUpdate" runat="server" Style="padding: 5px; font-size: 14px; font-weight: bold;
                                    color: Black;">
                                    4/28/1906 12:00:00 AM
                                </asp:Label>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnUpdate" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        Choose the effects, then press 'Update':<br />
        <input type="checkbox" id="effect_fade" checked="checked" /><label for="effect_fade">Fade</label><br />
        <input type="checkbox" id="effect_collapse" checked="checked" /><label for="effect_collapse">Collapse</label><br />
        <input type="checkbox" id="effect_color" checked="checked" /><label for="effect_color">Color
            Background</label><br />
        <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
        <ajaxToolkit:UpdatePanelAnimationExtender ID="upae" BehaviorID="animation" runat="server"
            TargetControlID="update">
            <Animations>
                <OnUpdating>
                    <Sequence>
                        <%-- Store the original height of the panel --%>
                        <ScriptAction Script="var b = $find('animation'); b._originalHeight = b._element.offsetHeight;" />
                        
                        <%-- Disable all the controls --%>
                        <Parallel duration="0">
                            <EnableAction AnimationTarget="btnUpdate" Enabled="false" />
                            <EnableAction AnimationTarget="effect_color" Enabled="false" />
                            <EnableAction AnimationTarget="effect_collapse" Enabled="false" />
                            <EnableAction AnimationTarget="effect_fade" Enabled="false" />
                        </Parallel>
                        <StyleAction Attribute="overflow" Value="hidden" />
                        
                        <%-- Do each of the selected effects --%>
                        <Parallel duration=".25" Fps="30">
                            <Condition ConditionScript="$get('effect_fade').checked">
                                <FadeOut AnimationTarget="divContainer" minimumOpacity=".2" />
                            </Condition>
                            <Condition ConditionScript="$get('effect_collapse').checked">
                                <Resize Height="0" />
                            </Condition>
                            <Condition ConditionScript="$get('effect_color').checked">
                                <Color AnimationTarget="divContainer" PropertyKey="backgroundColor"
                                    EndValue="#FFFF00" StartValue="#FFFFFF" />
                            </Condition>
                        </Parallel>
                    </Sequence>
                </OnUpdating>
                <OnUpdated>
                    <Sequence>
                        <%-- Do each of the selected effects --%>
                        <Parallel duration=".25" Fps="30">
                            <Condition ConditionScript="$get('effect_fade').checked">
                                <FadeIn AnimationTarget="divContainer" minimumOpacity=".2" />
                            </Condition>
                            <Condition ConditionScript="$get('effect_collapse').checked">
                                <%-- Get the stored height --%>
                                <Resize HeightScript="$find('animation')._originalHeight" />
                            </Condition>
                            <Condition ConditionScript="$get('effect_color').checked">
                                <Color AnimationTarget="divContainer" PropertyKey="backgroundColor"
                                    EndValue="#FFFFFF" StartValue="#FFFF00" />
                            </Condition>
                        </Parallel>
                        
                        <%-- Enable all the controls --%>
                        <Parallel duration="0">
                            <EnableAction AnimationTarget="effect_fade" Enabled="true" />
                            <EnableAction AnimationTarget="effect_collapse" Enabled="true" />
                            <EnableAction AnimationTarget="effect_color" Enabled="true" />
                            <EnableAction AnimationTarget="btnUpdate" Enabled="true" />
                        </Parallel>                            
                    </Sequence>
                </OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
    </form>
</body>
</html>

