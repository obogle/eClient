<!---

Author: Alyssa Morgan 




---->



<!--- Static navbar --->
    <nav class="navbar navbar-default navbar-static-top" ng-controller="menuCtrl">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" ng-click="navbarCollapsed = !navbarCollapsed">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="hidden-xs" style="padding:10px; text-align:left;">
                <img src="../img/logo.png" style="width:100%; max-height:100px; max-width:90px;padding-right:10px;" /><img src="../img/Click&Go_only.png" style="width: 100%; max-height:65px; max-width:95px;" />
                <!---<span style="color:#ffffff">Welcome {{clientInfo.clientName}}</span>--->
            </div>
            <div class="visible-xs"  style="text-align:left;padding:10px;">
                <img src="../img/Click&Go_logo.png" style="width: 100%; max-height:200px; max-width:130px; " /><!---<br/><span style="color:#ffffff">Welcome {{clientInfo.clientName}}</span>--->
            </div>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
   		<div class="collapse navbar-collapse" uib-collapse="!navbarCollapsed">
          <ul class="nav navbar-nav">
           
          </ul>
          <ul class="nav navbar-nav navbar-right">	
                    
                    <li ><a href ng-click="goToDash()"><i class="fa fa-home"></i> Home</a></li>
                    <!---<li><a href="##"><i class="fa fa-history"></i> Renewals</a></li>--->
                    <li><a href ng-click="viewTransactions()"><i class="fa fa-book"></i> View Transactions</a></li>
                    <li ><a ng-href="http://www.icwi.com"><i class="fa fa-laptop"></i> icwi.com</a></li>
                    <li ><a href ng-click="logout()"><i class="fa fa-sign-out"></i> Logout</a></li>

          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
<!--- / Static navbar --->

