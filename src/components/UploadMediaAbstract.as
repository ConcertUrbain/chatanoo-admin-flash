package components
{
	import flash.events.Event;
	import flash.net.FileFilter;
	
	import mx.containers.Canvas;
	import mx.controls.Button;
	import mx.controls.ProgressBar;
	import mx.controls.TextInput;
	
	import org.concert_urbain.touratour.UploadEvents;
	
	import mx.controls.ProgressBar;
	import mx.controls.ProgressBarMode;
	import mx.controls.Alert;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	
	// JSON API
	import org.concert_urbain.touratour.api.TAT;
	import org.concert_urbain.touratour.api.core.events.ServiceEvent;
	import org.concert_urbain.touratour.api.core.requests.AbstractServiceRequest;
	import org.concert_urbain.touratour.api.vos.*;
	import org.concert_urbain.touratour.api.vos.collections.MultiVoCollection;
	import org.concert_urbain.touratour.api.vos.collections.VoCollection;
	import org.concert_urbain.touratour.api.vos.datas.*;
	import org.concert_urbain.touratour.api.vos.events.VoEvent;
	import org.concert_urbain.touratour.api.vos.medias.*;
	
	import org.concert_urbain.touratour.events.*;
	import org.concert_urbain.utils.FileUtils;
	
	
	
	public class UploadMediaAbstract extends Canvas
	{

		
		// Id de l'utilisateur
		public var userId:Number = 0;
		
		// Paramètres de l'Upload
		protected var _serverPath:String = "http://mc.dring93.org/";
		protected var _uploadUrl:String = "upload";
		protected var _fileMaxSize:Number = 40 * 1024 * 1024;
		protected var _fileReference:FileReference;
		protected var _uploadFileReference:FileReference;
		
		// Boutons et éléments d'interface
		public var progressBar:ProgressBar;
		protected var btnRechercher:Button;
		protected var btnEnvoyer:Button;
		protected var txtFilename:TextInput;
		protected var txtTitle:TextInput;
		
		
		public function UploadMediaAbstract()
		{
		}
		
		protected function init():void
		{
			btnRechercher.enabled = true;
			btnEnvoyer.enabled = false;
			
			btnRechercher.addEventListener(MouseEvent.CLICK, browseHandler);
			btnEnvoyer.addEventListener(MouseEvent.CLICK, submitHandler);
			
			_fileReference = new FileReference();
			_fileReference.addEventListener(Event.SELECT, selectFileHandler);
			
			txtFilename.text = "";
			txtTitle.text = "";
			
			progressBar.mode = ProgressBarMode.MANUAL
			progressBar.minimum = 0;
			progressBar.maximum = 100;
		}				
		
		
		public function reset():void
		{
			if (btnRechercher) btnRechercher.enabled = true;
			if (btnEnvoyer) btnEnvoyer.enabled = false;
			
			if (txtFilename) txtFilename.text = "";
			if (txtTitle) txtTitle.text = "";
		}
		
		
		//
		// Upload des médias 
		//
		
		protected function browseHandler(event:Event):void
		{
			var success:Boolean = _fileReference.browse(getTypes());
		}
		
		//
		// Types acceptés
		//

		private function getTypes():Array {
			var allTypes:Array = new Array(getImageTypeFilter(), getVideoTypeFilter(), getAudioTypeFilter());
			return allTypes;
		}
		
		private function getImageTypeFilter():FileFilter {
			return new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png");
		}
		
		private function getVideoTypeFilter():FileFilter {
			return new FileFilter("Videos (*.flv, *.mp4, *.mov, *.3gp, *.wmv)", "*.flv;*.mp4;*.mov;*.3gp;*.wmv");
		}
		
		private function getAudioTypeFilter():FileFilter {
			return new FileFilter("Sounds (*.mp3, *.wav, *.aac, *.m4a)", "*.mp3;*.wav;*.aac;*.m4a");
		}
		
		//
		// Fichier sélectionné
		//
		
		protected function selectFileHandler(event:Event):void
		{
			btnEnvoyer.enabled = _fileReference.name.length > 0;
			txtFilename.text = _fileReference.name;
		}
		
		protected function submitHandler(event:Event):void
		{
			_uploadFileReference = _fileReference;
			
			if (_uploadFileReference.size < _fileMaxSize)
			{
				btnEnvoyer.enabled = false;
				btnRechercher.enabled = false;
				
				progressBar.setProgress(0, 100);
				
				var request:URLRequest = new URLRequest();
				request.url = _serverPath + _uploadUrl;
				request.method =  URLRequestMethod.POST;
				
				trace("submit upload", _serverPath + _uploadUrl);
				
				_uploadFileReference.addEventListener(ProgressEvent.PROGRESS, onUploadProgress);
				_uploadFileReference.addEventListener(Event.COMPLETE, onUploadComplete);
				_uploadFileReference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, onResultHandler);
				_uploadFileReference.addEventListener(IOErrorEvent.IO_ERROR, onUploadIoError);
				_uploadFileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onUploadSecurityError);
				
				// "media" --> référence récupérée par le script PHP d'upload
				_uploadFileReference.upload(request, "file", false);
				
				// Début de l'upload
				dispatchEvent(new Event(UploadEvents.UPLOAD_INIT));
				
			}
			else
			{			
				var maxMo:Number = _fileMaxSize/1024/1024;
				var maxMoStr:String = String(Math.floor(maxMo*10)/10);
				var nbsp:String = String.fromCharCode(160);
				
				btnEnvoyer.enabled = false;
				btnRechercher.enabled = true;
				
				Alert.show("Le poids du fichier ne doit pas dépasser" + nbsp + maxMoStr + nbsp + "Mo.");
			}
		}
		
		protected function onUploadProgress(event:ProgressEvent):void
		{
			var numPerc:Number = Math.round((Number(event.bytesLoaded) / Number(event.bytesTotal)) * 100);
			
			// numPerc + "%";
			progressBar.setProgress(numPerc, 100);
			
			if (numPerc >= 100)
			{
				progressBar.setProgress(100, 100);
			}
		}
		
		protected function onUploadComplete(event:Event):void
		{
			trace("upload complete");
		}
		
		protected function onUploadIoError(event:IOErrorEvent):void
		{
			Alert.show("onUploadIoError : "+event.text);
			uploadError();
		}
		
		protected function onUploadSecurityError(event:SecurityErrorEvent):void
		{
			Alert.show("onUploadSecurityError : "+event.text);
			uploadError();
		}
		
		protected function uploadError():void
		{
			btnEnvoyer.enabled = false;
			btnRechercher.enabled = true;
			
			// Echec de l'upload
			dispatchEvent(new Event(UploadEvents.UPLOAD_ERROR));
			
			_uploadFileReference.removeEventListener(ProgressEvent.PROGRESS, onUploadProgress);
			_uploadFileReference.removeEventListener(Event.COMPLETE, onUploadComplete);
			_uploadFileReference.removeEventListener(IOErrorEvent.IO_ERROR, onUploadIoError);
			_uploadFileReference.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onUploadSecurityError);
			_uploadFileReference.cancel();
		}
		
		protected function onResultHandler(event:DataEvent):void
		{
			try
			{
				var uploadResult:String = String(event.data);
				trace("uploadResult", uploadResult);
				
				if (uploadResult.indexOf("Invalid") == -1)
				{
					//
					// Prévient que l'upload s'est achevé avec succès :
					//
					
					// Nom du fichier dans le Media Center
					var uploadResultArray:Array = uploadResult.split(String.fromCharCode(10));
					var fileName:String = uploadResultArray.length == 1 ? uploadResultArray[0] : uploadResultArray[1];
						
					// Ajout à la base de données
					addMedia(fileName); 
					
					// On met à jour le formulaire
					txtFilename.text = "";
					txtTitle.text = "";
					progressBar.setProgress(0, 100);
					btnRechercher.enabled = true;
				}
			}
			catch (error:Error)
			{
				btnEnvoyer.enabled = false;
				btnRechercher.enabled = true;
			}
		}
		
		//
		// To Override :
		//
		
		protected function addMedia(fileName:String):void
		{
		}
		
		protected function getFileTypeFromPath(fileURL:String):String
		{
			var fileSuffix:String = fileURL.substr(-2, 2);
			var fileType:String;
			
			switch(fileSuffix)
			{
				case "-P":
					//
					// Picture
					//
					fileType = "Picture";
					break;
				
				case "-V":
					//
					// Video
					//
					fileType = "Video";
					break;
				
				case "-A" :
					//
					// Sound
					//
					fileType = "Sound";
					break;
			}
			
			return fileType;
		}
	}
}