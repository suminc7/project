using UnityEngine;
using System.Collections;

public class PopupBox : MonoBehaviour {

	public SelectWeponBox WeponBox1;
	public SelectWeponBox WeponBox2;
	public SelectWeponBox WeponBox3;
	public ShowHand showHand;
	public KnightControl hero;

	void Start () {
		Vector3 pos = transform.position + new Vector3 (0, 10, 0);
		transform.position = pos;
		//gameObject.SetActive (false);
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	public void Active(){
		gameObject.SetActive (true);
		LeanTween.moveY(gameObject, 8f, 6.0f) .setEase( LeanTweenType.easeOutQuad ).setOnComplete(ActiveComplete);
	}

	void ActiveComplete(){
		if (FirstPersonControl.VR) {
			hero.HandUp();
			StartCoroutine (SelectSword (1F));
		} else {

			//StartCoroutine (SelectSword (15F));
		}
	}
	
	IEnumerator SelectSword(float waitTime) {
		yield return new WaitForSeconds(waitTime);
		if(!showHand.GetSelected()){
			WeponBox2.ActiveVR();	
		}

	}

	void onCompleteFunc(){
		gameObject.SetActive (false);
	}

	public void Deactive(){
		LeanTween.moveY(gameObject, 18, 6.0f) .setEase( LeanTweenType.easeOutQuad ).setOnComplete( onCompleteFunc );
	}
}
