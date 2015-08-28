using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Brilliantech.Framwork.Utils.LogUtil;
using System.Text.RegularExpressions;
using System.IO;
using System.Diagnostics;

namespace MoldClientCon
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                // 路径必须双斜杠\\
                // args = new string[] { "mold:open?file=d:\\bb.xps&local=true" };
                // 记录参数
                LogUtil.Logger.Info("接受到参数：");
                LogUtil.Logger.Info(args);
                // 盘点参数是否存在
                if (args.Length > 0)
                {
                    // 去除前缀
                    Regex removePrefixRegex = new Regex("mold:", RegexOptions.IgnoreCase);
                    string arg = removePrefixRegex.Replace(args[0], "");

                    // 获取方法
                    string action = GetAction(arg);

                    // 获取参数
                    Dictionary<string, string> paramsDic = GetParams(arg);


                    // 进入方法判断
                    switch (action)
                    {
                        case "open":
                            OpenFile(paramsDic["file"]);
                            break;
                        default:
                            LogUtil.Logger.Error("没有此方法：" + action);
                            break;
                    }
                   // LogUtil.Logger.Info(action);
                   // LogUtil.Logger.Info(arg);
                    //  Console.Read();
                }
                else
                {
                    LogUtil.Logger.Error("未传递参数");
                }
            }
            catch (Exception e)
            {
                LogUtil.Logger.Error(e.Message);
            }
        }

        /// <summary>
        /// 通过正则匹配 方法
        /// </summary>
        /// <param name="arg"></param>
        /// <returns></returns>
        static string GetAction(string arg)
        {
            Regex getActionRegex = new Regex(@"^\w+\?", RegexOptions.IgnoreCase);
            return getActionRegex.Match(arg).ToString().TrimEnd('?');
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="arg"></param>
        /// <returns></returns>
        static Dictionary<string, string> GetParams(string arg)
        {
            Dictionary<string, string> paramDic = new Dictionary<string, string>();
            Regex removeActionRegex = new Regex(@"^\w+\?", RegexOptions.IgnoreCase);
            string paramString = removeActionRegex.Replace(arg, "");

            Regex getParamsRegex = new Regex(@"\w+=\w+(\w+|:|\\|\.)*", RegexOptions.IgnoreCase);
            MatchCollection matchCollection = getParamsRegex.Matches(paramString);
            foreach (var m in matchCollection)
            {
                string[] param = m.ToString().Split('=');
                paramDic.Add(param[0], param[1]);
            }
            return paramDic;
        }

        /// <summary>
        /// 打开文件 或 文件路径
        /// </summary>
        /// <param name="file"></param>
        static void OpenFile(string file)
        {
            LogUtil.Logger.Info("开始打开：" + file);
            bool e = Directory.Exists(@file) || File.Exists(@file);
            if (e)
            {
                Process.Start(@file);
                LogUtil.Logger.Info("成功打开文件路径");
            }
            else
            {
                // LogUtil.Logger.Error("未传递参数");
                throw new FileNotFoundException("文件路径不存在");
            }

        }
    }
}
